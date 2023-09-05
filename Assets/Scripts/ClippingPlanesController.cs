using UnityEngine;

[ExecuteInEditMode]
public class ClippingPlanesController : MonoBehaviour
{
    public Material[] targetMaterials;

    public Vector3 clipPlaneXPos;
    public Vector3 clipPlaneXNormal;
    public Vector3 clipPlaneYPos;
    public Vector3 clipPlaneYNormal;
    public Vector3 clipPlaneZPos;
    public Vector3 clipPlaneZNormal;

    public bool followPosition = true;
    public bool followRotation = true;

    private Transform objectTransform;

    void Start()
    {
        objectTransform = this.transform;
    }

    void Update()
    {

        if (!followRotation)
        {
            Vector3 gameObjectPos = followPosition ? this.transform.position : Vector3.zero;

            foreach (Material targetMaterial in targetMaterials)
            {
                targetMaterial.SetVector("_ClipPlaneXPos", new Vector4(clipPlaneXPos.x + gameObjectPos.x, clipPlaneXPos.y + gameObjectPos.y, clipPlaneXPos.z + gameObjectPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneXNormal", followRotation ? this.transform.rotation * clipPlaneXNormal : clipPlaneXNormal);

                targetMaterial.SetVector("_ClipPlaneYPos", new Vector4(clipPlaneYPos.x + gameObjectPos.x, clipPlaneYPos.y + gameObjectPos.y, clipPlaneYPos.z + gameObjectPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneYNormal", followRotation ? this.transform.rotation * clipPlaneYNormal : clipPlaneYNormal);

                targetMaterial.SetVector("_ClipPlaneZPos", new Vector4(clipPlaneZPos.x + gameObjectPos.x, clipPlaneZPos.y + gameObjectPos.y, clipPlaneZPos.z + gameObjectPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneZNormal", followRotation ? this.transform.rotation * clipPlaneZNormal : clipPlaneZNormal);
            }
        }


        if (followRotation)
        {
            foreach (Material targetMaterial in targetMaterials)
            {
                Vector3 worldClipPlaneXPos = followPosition ? objectTransform.TransformPoint(clipPlaneXPos) : clipPlaneXPos;
                Vector3 worldClipPlaneXNormal = followRotation ? objectTransform.TransformDirection(clipPlaneXNormal) : clipPlaneXNormal;

                Vector3 worldClipPlaneYPos = followPosition ? objectTransform.TransformPoint(clipPlaneYPos) : clipPlaneYPos;
                Vector3 worldClipPlaneYNormal = followRotation ? objectTransform.TransformDirection(clipPlaneYNormal) : clipPlaneYNormal;

                Vector3 worldClipPlaneZPos = followPosition ? objectTransform.TransformPoint(clipPlaneZPos) : clipPlaneZPos;
                Vector3 worldClipPlaneZNormal = followRotation ? objectTransform.TransformDirection(clipPlaneZNormal) : clipPlaneZNormal;

                targetMaterial.SetVector("_ClipPlaneXPos", new Vector4(worldClipPlaneXPos.x, worldClipPlaneXPos.y, worldClipPlaneXPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneXNormal", worldClipPlaneXNormal);

                targetMaterial.SetVector("_ClipPlaneYPos", new Vector4(worldClipPlaneYPos.x, worldClipPlaneYPos.y, worldClipPlaneYPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneYNormal", worldClipPlaneYNormal);

                targetMaterial.SetVector("_ClipPlaneZPos", new Vector4(worldClipPlaneZPos.x, worldClipPlaneZPos.y, worldClipPlaneZPos.z, 0));
                targetMaterial.SetVector("_ClipPlaneZNormal", worldClipPlaneZNormal);
            }
        }
    }


   
    // Clip Planes value methods

    public void UpdateClipPlaneXPos(float newValue)
    {
        clipPlaneXPos.x = newValue;
    }

    public void UpdateClipPlaneYPos(float newValue)
    {
        clipPlaneYPos.y = newValue;
    }

    public void UpdateClipPlaneZPos(float newValue)
    {
        clipPlaneZPos.z = newValue;
    }


    // Follow Rotation Method
    public void UpdateFollowRotation(bool newValue)
    {
        followRotation = newValue;
    }


    // Normal Directions or Disable Planes Methods

    public void OnDropdownValueChangedX(int index)
    {
        int mappedValue;
        if (index == 2)
        {
            mappedValue = index - 3; // This will transform 2 to -1
        }
        else
        {
            mappedValue = index;
        }

        // Now use mappedValue as the normal direction
        clipPlaneXNormal = new Vector3(mappedValue, 0, 0);
    }

    public void OnDropdownValueChangedY(int index)
    {
        int mappedValue;
        if (index == 2)
        {
            mappedValue = index - 3; // This will transform 2 to -1
        }
        else
        {
            mappedValue = index;
        }

        // Now use mappedValue as your normal direction
        clipPlaneYNormal = new Vector3(0, mappedValue, 0);
    }

    public void OnDropdownValueChangedZ(int index)
    {
        int mappedValue;
        if (index == 2)
        {
            mappedValue = index - 3; // This will transform 2 to -1
        }
        else
        {
            mappedValue = index;
        }

        // Now use mappedValue as your normal direction
        clipPlaneZNormal = new Vector3(0, 0, mappedValue);
    }



}